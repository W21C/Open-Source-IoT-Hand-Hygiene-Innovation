from . import main
from .. import db
from .forms import RequestData, PumpForm, RequestExport
from ..models import Pump, Trigger
import datetime

import pyexcel as pe
import matplotlib.pyplot as plt
from flask import render_template, redirect, url_for, flash, request, Response,make_response
from io import StringIO
import csv
import ast

pumps = []
totals = []
average = []


def creategraph(topic, start, end, pumps, type):
    data = Trigger.query.filter(Trigger.datetime >= start, Trigger.datetime <= end).all()
    print("this is the data:", data)
    ys = []
    xs = []
    y = start
    count = 0
    pumpcount = len(pumps)
    pumpcounts = [0] * pumpcount
    pumpsnested = []
    global pump_total

    for each in pumps:
        pumpsnested.append([])

    if topic == 'hour':
        while y < end:
            ymax = y + datetime.timedelta(minutes=1)
            for each in data:
                if each.pump in pumps:
                    if y < each.datetime < ymax:
                        count += 1
                        temp = pumps.index(each.pump)
                        pumpcounts[temp] += 1
                    else:
                        continue
            for index, each in enumerate(pumpcounts):
                pumpsnested[index].append(each)
            ys.append(count)
            count = 0
            pumpcounts = [0] * pumpcount
            y += datetime.timedelta(minutes=1)

        # X-Axis
        x = start
        while x < end:
            xs.append(x.strftime('%H:%M'))
            x += datetime.timedelta(minutes=1)

        color = 'dimgrey'

    elif topic == 'day':
        while y < end:
            ymax = y + datetime.timedelta(hours=1)

            for each in data:
                if each.pump in pumps:
                    if y < each.datetime < ymax:
                        count += 1
                        temp = pumps.index(each.pump)
                        pumpcounts[temp] += 1
                    else:
                        continue

            for index, each in enumerate(pumpcounts):
                pumpsnested[index].append(each)
            ys.append(count)
            count = 0
            pumpcounts = [0] * pumpcount

            y += datetime.timedelta(hours=1)

        # X-Axis
        x = start
        while x < end:
            xs.append(x.strftime('%H:%M'))
            x += datetime.timedelta(hours=1)
        color = 'dimgrey'

    elif topic == 'week':
        while y < end:
            ymax = y + datetime.timedelta(days=1)
            for each in data:
                if each.pump in pumps:
                    if y < each.datetime < ymax:
                        count += 1
                        temp = pumps.index(each.pump)
                        pumpcounts[temp] += 1
                    else:
                        continue
            for index, each in enumerate(pumpcounts):
                pumpsnested[index].append(each)
            ys.append(count)
            count = 0
            pumpcounts = [0] * pumpcount

            y += datetime.timedelta(days=1)

        # X-Axis
        x = start
        while x < end:
            xs.append(x.strftime('%a'))
            x += datetime.timedelta(days=1)

        color = 'dimgrey'

    elif topic == 'month':
        while y < end:
            ymax = y + datetime.timedelta(days=1)
            for each in data:
                if each.pump in pumps:
                    if y < each.datetime < ymax:
                        count += 1
                        temp = pumps.index(each.pump)
                        pumpcounts[temp] += 1
                    else:
                        continue
            for index, each in enumerate(pumpcounts):
                pumpsnested[index].append(each)
            ys.append(count)
            count = 0
            pumpcounts = [0] * pumpcount

            y += datetime.timedelta(days=1)

        # X-Axis
        x = start
        while x < end:
            xs.append(x.strftime('%x'))
            x += datetime.timedelta(days=1)

        color = 'dimgrey'

    elif topic == 'custom':

        while y < end:
            ymax = y + datetime.timedelta(days=1)
            for each in data:
                if each.pump in pumps:
                    if y < each.datetime < ymax:
                        count += 1
                        temp = pumps.index(each.pump)
                        pumpcounts[temp] += 1
                    else:
                        continue
            for index, each in enumerate(pumpcounts):
                pumpsnested[index].append(each)
            ys.append(count)
            count = 0
            pumpcounts = [0] * pumpcount

            y += datetime.timedelta(days=1)

        # X-Axis
        x = start
        while x < end:
            xs.append(x.strftime('%x'))
            x += datetime.timedelta(days=1)

        color = 'dimgrey'

    else:
        print("I gave up because this was my topic: {}.".format(topic))
        return

    if type == 'line':
        plt.style.use('seaborn-dark')
        plt.plot(xs, ys, color=color, label='Total use')
        n = 0
        totals = []
        for each in pumpsnested:
            totals.append(sum(each))
            ys = each
            label = "Pump {}".format(pumps[n])
            n += 1
            try:
                plt.plot(xs, ys, label=label)
                plt.xlabel('Time/Date')
                plt.ylabel('Times used')
            except:
                print('I screwed up the {}'.format(topic))
                continue

    elif type == 'bar':
        plt.style.use('seaborn-dark')
        totals = []
        for each in pumpsnested:
            totals.append(sum(each))
        print(totals)
        for i in range(0, pumpcount):
            plt.bar(pumps[i], totals[i], color=plt.cm.jet(1. * i / len(totals)))

        plt.xlabel('Pump IDs')
        plt.ylabel('Times used')


    else:
        print("I gave up because this was my type: {}.".format(type))
        return

    plt.legend(bbox_to_anchor=(1, 1),
               bbox_transform=plt.gcf().transFigure)
    plt.xticks(rotation='vertical')
    if topic != 'custom':
        plt.title('Use this {}'.format(topic))
    else:
        plt.title('Use between {} and {}'.format(start.strftime('%x'),end.strftime('%x')))
    # plt.savefig('app/static/images/plot_{}.png'.format(topic))
    plt.savefig('app/static/images/mainGraph.png')
    plt.clf()
    delta = end - start
    average = []
    for each in totals:
        each = each/delta.days
        average.append(int(each))
    print(pumps, totals, average)
    return pumps, totals, average


# Index page
@main.route('/', methods=['GET', 'POST'])
def index():
    global pumps, totals, average
    # Load battery levels
    battery = [each.volt for each in Pump.query.all()]
    pumps = [each.payload for each in Pump.query.all()]
    print(battery)
    battery_p = []
    for each in battery:
        p = ((each-2000)/1000)*100
        if p > 100:
            p = 100
        elif p < 0:
            p = 0
        battery_p.append(int(p))

    print(battery_p)

    # Data plotting of last week
    now = datetime.datetime.now()
    weekquery = now - datetime.timedelta(days=7)

    ALL = [str(each.payload) for each in Pump.query.all()]

    form = RequestData()
    form.pump.choices = [(str(each.payload), str(each.payload)) for each in Pump.query.all()]

    pumps, totals, average= creategraph('week', weekquery, now, ALL, 'line')

    if request.method == 'POST':

        pumps = form.pump.data
        if pumps == []:
            pumps = ALL

        topic = form.topic.data
        if topic == 'custom':
            if form.date1.data == None:
                topic = 'week'
                d1 = now - datetime.timedelta(days=7)
                d2 = now
            else:
                date1 = form.date1.data
                d1 = datetime.datetime.combine(date1, datetime.datetime.min.time())
                date2 = form.date2.data
                d2 = datetime.datetime.combine(date2, datetime.datetime.min.time()) + datetime.timedelta(days=1)
        else:
            d2 = now
            if topic == 'hour':
                d1 = now - datetime.timedelta(hours=1)
            if topic == 'day':
                d1 = now - datetime.timedelta(days=1)
            if topic == 'week':
                d1 = now - datetime.timedelta(days=7)
            if topic == 'month':
                d1 = now - datetime.timedelta(days=30)

        type = form.type.data
        print(topic, d1, d2, pumps, type)
        pumps, totals, average = creategraph(topic, d1, d2, pumps, type)
        return redirect(url_for('main.custom', pumps=pumps, totals=totals, average=average))

    return render_template('index.html', form=form, battery=battery_p, pumps=pumps, totals=totals, average=average)


@main.route('/config', methods=['GET', 'POST'])
def config():
    form = PumpForm()
    pumps = Pump.query.all()
    if form.validate_on_submit():
        pump = Pump(payload=form.payload.data,
                    location=form.location.data,
                    )
        db.session.add(pump)
        db.session.commit()
        return redirect(url_for('main.config'))
    return render_template('config.html', form=form, pumps=pumps)


@main.route('/custom', methods=['GET', 'POST'])
def custom():
    global pumps, totals, average
    form = RequestData()
    form.pump.choices = [(str(each.payload), str(each.payload)) for each in Pump.query.all()]

    if request.method == 'POST':
        now = datetime.datetime.now()
        ALL = [str(each.payload) for each in Pump.query.all()]

        pumps = form.pump.data
        if pumps == []:
            pumps = ALL

        topic = form.topic.data

        if topic == 'custom':
            if form.date1.data == None:
                topic = 'week'
                d1 = now - datetime.timedelta(days=7)
                d2 = now
            else:
                date1 = form.date1.data
                d1 = datetime.datetime.combine(date1, datetime.datetime.min.time())
                if form.date2.data == None:
                    d2 = now
                else:
                    date2 = form.date2.data
                    d2 = datetime.datetime.combine(date2, datetime.datetime.min.time()) + datetime.timedelta(days=1)
        else:
            d2 = now
            if topic == 'hour':
                d1 = now - datetime.timedelta(hours=1)
            if topic == 'day':
                d1 = now - datetime.timedelta(days=1)
            if topic == 'week':
                d1 = now - datetime.timedelta(days=7)
            if topic == 'month':
                d1 = now - datetime.timedelta(days=30)

        type = form.type.data
        print(topic, d1, d2, pumps, type)
        pumps, totals, average = creategraph(topic, d1, d2, pumps, type)
        return redirect(url_for('main.custom', pumps=pumps, totals=totals, average=average))
    return render_template('custom.html', form=form, pumps=pumps, totals=totals, average=average)


@main.route('/export', methods=['GET', 'POST'])
def export():
    form = RequestExport()

    if request.method == 'POST':
        now = datetime.datetime.now()

        if form.date1.data == None:
            topic = 'week'
            d1 = now - datetime.timedelta(days=7)
            d2 = now
        else:
            date1 = form.date1.data
            d1 = datetime.datetime.combine(date1, datetime.datetime.min.time())
            if form.date2.data == None:
                d2 = now
            else:
                date2 = form.date2.data
                d2 = datetime.datetime.combine(date2, datetime.datetime.min.time()) + datetime.timedelta(days=1)

        return redirect(url_for('main.csv', d1=d1, d2=d2))
    return render_template('export.html', form=form)


@main.route('/download/<d1>/<d2>.csv')
def csv(d1, d2):
    query = Trigger.query.filter(Trigger.datetime >= d1, Trigger.datetime <= d2).all()
    data = [(each.datetime, each.pump)for each in query]
    sheet = pe.Sheet(data)
    io = StringIO()
    sheet.save_to_memory("csv", io)
    output = make_response(io.getvalue())
    output.headers["Content-Disposition"] = "attachment; filename=export.csv"
    output.headers["Content-type"] = "text/csv"
    return output


