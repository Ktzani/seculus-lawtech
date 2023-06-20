import { userInfo } from 'os';
import { prisma } from '../../lib/prisma'
import * as bcrypt from 'bcryptjs';

class Usuario {
    async New(primeiro_nome: string, sobrenome: string, email: string, password: string, logradouro: string, complemento: string | undefined, numero: number, bairro: string, cep: string, cidade: string, uf: string ){
        
        //Fazer regex para pegar apenas os caracteres do cep

        //Hash -> senha crua modifidacada
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(password, salt);

        return await prisma.usuario.create({
            data: {
                primeiro_nome,
                sobrenome, 
                email, 
                senha: hash,
                logradouro,
                complemento,
                numero,
                bairro,
                cep,
                cidade,
                uf
            }
        })
        
    }

    async FindByEmail(email: string){
        const user = await prisma.usuario.findFirst({
			where: {
				email
			}
		});
    }
    
}

export const UsuarioClass = new Usuario()