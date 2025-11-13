import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';

const app = express();
app.use(cors({ origin: process.env.ALLOWED_ORIGINS || '*' }));
app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.json({ status: 'Evolution API ativa 🚀', version: '1.0.0' });
});

app.post('/webhook', (req, res) => {
  console.log('Webhook recebido:', JSON.stringify(req.body));
  res.sendStatus(200);
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Evolution API online na porta ${port}`);
});
