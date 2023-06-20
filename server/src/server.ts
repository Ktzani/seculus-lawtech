import 'dotenv/config'

import Fastify from "fastify";
import cors from "@fastify/cors"
import jwt from "@fastify/jwt"

import { usuariosRoutes } from './routes/usuarios.routes';
import { custasRoutes } from './routes/custas.routes';
import { processosRoutes } from './routes/processos.routes';

const port = 3333
const app = Fastify()

app.register(cors, {
    origin: ["https://localhost:8080"]
}) // Aqui posso colocar quais endereços do front podem acessar o back

app.register(jwt, {
    secret: "351 hgfn2130ericjm1358nb 24372 vc37r631"
})

app.register(usuariosRoutes)
app.register(custasRoutes)
app.register(processosRoutes)

app.listen({
    port: port,
}).then(() => {
    console.log('HTTP server running on localhost:' + port)
})