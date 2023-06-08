import Fastify from "fastify";
import cors from "@fastify/cors"
import { PrismaClient } from "@prisma/client";

const app = Fastify()
const prisma = new PrismaClient()

app.register(cors, {
    origin: ["https://localhost:8080"]
}) // Aqui posso colocar quais endereços do front podem acessar o back

app.get('/', async (req, res) => {
   const habits = await prisma.aluno.findFirst({
    where:{
        name: "Catiza"
    }
   })

   res.send(habits)
})

app.listen({
    port: 8080 
}).then(() => {
    console.log("Servidor rodando na porta 8080")
})