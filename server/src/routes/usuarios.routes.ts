import { UsuarioClass } from '../models/Usuarios/UsuarioClass';
import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from 'zod'

export async function usuariosRoutes (app: FastifyInstance) {
    app.post('/register', async (request) => {
    	const bodySchema = z.object({
        	primeiro_nome: z.string(),
			sobrenome: z.string(),
            email: z.coerce.string().email(),
            senha: z.string(),
            logradouro: z.string(),
            complemento: z.string() || z.null(),
            numero: z.number(),
            bairro: z.string(),
            cep: z.string(),
            cidade: z.string(),
            uf: z.string()
      	})

		const usuarioInfo  = bodySchema.parse(request.body)

		let usuarioCriado = UsuarioClass.New(usuarioInfo)
  
      	return {
			usuarioCriado
		}
	
    })

    app.post("/login", async (request) => {
		const bodySchema = z.object({
        	email: z.string(),
			senha: z.coerce.string().email().min(5)
      	})


		const user = await prisma.usuario.findFirst({
			where: {
				login
			}
		});

		if (!user) {
			return res.status(404).send({err: 'Usuário não encontrado'});
		}

		const correctUser = bcrypt.compareSync(password, user.password);

		if (!correctUser) {
			return res.status(400).send({err: 'Senha incorreta'});
		}

		try {
			//const token = jwt.sign({id: user.id, login: user.login}, secret, {expiresIn: '12h'});
			const token = await app.jwtSign({login: user.login}, {sign: { sub: user.id}});
			return {
				token
			}
		} catch(err) {
			return res.status(400).send({msg: 'Falha interna', err});
		}
    })
}