const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
res.send('¡Hola desde Kubernetes, soy Lucia!');
});

app.listen(PORT, () => {
console.log(`Servidor corriendo en el puerto ${PORT}`);
});
