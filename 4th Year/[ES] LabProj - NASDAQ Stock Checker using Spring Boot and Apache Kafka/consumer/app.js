const { Kafka, logLevel } = require('kafkajs')
var express = require('express');
var expressWs = require('express-ws');
var sleep = require('sleep');
sleep.sleep(15);
var expressWs = expressWs(express());
var app = expressWs.app;

app.use(express.static('public'));
var aWss = expressWs.getWss('/');

mode = process.env.MODE
 
app.get('/', function(request, response){
    response.sendFile('/app/' + mode + '.html');
});
 
app.ws('/', function(ws, req) {
  ws.on('message', function(msg) {
    console.log(msg);
  });
  console.log('socket has connected');
});

const host = process.env.KAFKA_HOST

const kafka = new Kafka({
  logLevel: logLevel.INFO,
  brokers: [`${host}:9092`],
  clientId: mode + '-consumer',
  retry: {
    initialRetryTime: 100,
    maxRetryTime: 1000,
    retries: 50
  }
})

const topic = mode
const consumer = kafka.consumer({ groupId: mode + '-group' })

const run = async () => {
  await consumer.connect()
  await consumer.subscribe({ topic, fromBeginning: true })
  await consumer.run({

    eachMessage: async ({ topic, partition, message }) => {
      const prefix = `${topic}[${partition} | ${message.offset}] / ${message.timestamp}`
      console.log(`- ${prefix} ${message.key}#${message.value}`)

      aWss.clients.forEach(function (client) {
        client.send(message.value.toString());
      });

    },
  })
}

run().catch(e => console.error(`[example/consumer] ${e.message}`, e))

const errorTypes = ['unhandledRejection', 'uncaughtException']
const signalTraps = ['SIGTERM', 'SIGINT', 'SIGUSR2']

errorTypes.map(type => {
  process.on(type, async e => {
    try {
      console.log(`process.on ${type}`)
      console.error(e)
      await consumer.disconnect()
      process.exit(0)
    } catch (_) {
      process.exit(1)
    }
  })
})

signalTraps.map(type => {
  process.once(type, async () => {
    try {
      await consumer.disconnect()
    } finally {
      process.kill(process.pid, type)
    }
  })
})

app.listen(8080);
