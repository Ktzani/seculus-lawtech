/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "usuarios" (
    "id" TEXT NOT NULL,
    "primeiro_nome" TEXT NOT NULL,
    "sobrenome" TEXT NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "senha" VARCHAR(50) NOT NULL,
    "logradouro" VARCHAR(50) NOT NULL,
    "complemento" VARCHAR(20),
    "numero" INTEGER NOT NULL,
    "bairro" VARCHAR(50) NOT NULL,
    "cep" VARCHAR(9) NOT NULL,
    "cidade" VARCHAR(50) NOT NULL,
    "uf" CHAR(2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "advogados" (
    "id_usuario" TEXT NOT NULL,
    "oab" VARCHAR(20),
    "estagiario" BOOLEAN NOT NULL DEFAULT false,
    "cnpj_escritorio_advocacia" TEXT,

    CONSTRAINT "advogados_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "pessoa_fisica" (
    "id_usuario" TEXT NOT NULL,
    "cpf" VARCHAR(12) NOT NULL,
    "estado_civil" VARCHAR(20) NOT NULL,
    "sexo" CHAR(2) NOT NULL,
    "data_nascimento" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pessoa_fisica_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "pessoa_juridica" (
    "id_usuario" TEXT NOT NULL,
    "cnpj" VARCHAR(15) NOT NULL,
    "data_abertura" TIMESTAMP(3) NOT NULL,
    "razao_social" VARCHAR(50) NOT NULL,

    CONSTRAINT "pessoa_juridica_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "administradores" (
    "id_usuario" TEXT NOT NULL,
    "nivel" INTEGER NOT NULL,

    CONSTRAINT "administradores_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "telefones_usuarios" (
    "id_usuario" TEXT NOT NULL,
    "telefone" VARCHAR(20) NOT NULL,

    CONSTRAINT "telefones_usuarios_pkey" PRIMARY KEY ("id_usuario","telefone")
);

-- CreateTable
CREATE TABLE "defesas" (
    "id_advogado" TEXT NOT NULL,
    "id_cliente" TEXT NOT NULL,

    CONSTRAINT "defesas_pkey" PRIMARY KEY ("id_advogado","id_cliente")
);

-- CreateTable
CREATE TABLE "escritorios_advocacia" (
    "cnpj" VARCHAR(15) NOT NULL,
    "nome" TEXT NOT NULL,
    "sigla" VARCHAR(10),
    "incricao_oab" VARCHAR(30) NOT NULL,
    "logradouro" VARCHAR(50) NOT NULL,
    "complemento" VARCHAR(20),
    "numero" INTEGER NOT NULL,
    "bairro" VARCHAR(50) NOT NULL,
    "cep" VARCHAR(9) NOT NULL,
    "cidade" VARCHAR(50) NOT NULL,
    "uf" CHAR(2) NOT NULL,

    CONSTRAINT "escritorios_advocacia_pkey" PRIMARY KEY ("cnpj")
);

-- CreateTable
CREATE TABLE "telefones_escritorios" (
    "cnpj_escritorio" TEXT NOT NULL,
    "telefone" VARCHAR(20) NOT NULL,

    CONSTRAINT "telefones_escritorios_pkey" PRIMARY KEY ("cnpj_escritorio","telefone")
);

-- CreateTable
CREATE TABLE "processos_juridicos" (
    "numero" VARCHAR(30) NOT NULL,
    "grau" VARCHAR(10) NOT NULL,
    "causa" TEXT NOT NULL,
    "data_inicio" TIMESTAMP(3) NOT NULL,
    "data_final" TIMESTAMP(3),
    "valor_causa" DOUBLE PRECISION NOT NULL,
    "id_advogado" TEXT NOT NULL,
    "id_cliente" TEXT NOT NULL,
    "cnpj_beneficiario" TEXT NOT NULL,

    CONSTRAINT "processos_juridicos_pkey" PRIMARY KEY ("numero")
);

-- CreateTable
CREATE TABLE "beneficiarios" (
    "cnpj" VARCHAR(15) NOT NULL,
    "nome" VARCHAR(50) NOT NULL,
    "sigla" TEXT,

    CONSTRAINT "beneficiarios_pkey" PRIMARY KEY ("cnpj")
);

-- CreateTable
CREATE TABLE "beneficiarios_estaduais" (
    "cnpj_beneficiario" VARCHAR(50) NOT NULL,
    "uf" CHAR(2) NOT NULL,

    CONSTRAINT "beneficiarios_estaduais_pkey" PRIMARY KEY ("cnpj_beneficiario")
);

-- CreateTable
CREATE TABLE "beneficiarios_federais" (
    "cnpj_beneficiario" VARCHAR(50) NOT NULL,
    "regiao" TEXT NOT NULL,

    CONSTRAINT "beneficiarios_federais_pkey" PRIMARY KEY ("cnpj_beneficiario")
);

-- CreateTable
CREATE TABLE "custas_judiciais" (
    "codigo" VARCHAR(100) NOT NULL,
    "tipo" VARCHAR(50) NOT NULL,
    "data_emissao" TIMESTAMP(3) NOT NULL,
    "data_validade" TIMESTAMP(3) NOT NULL,
    "valor_total" DOUBLE PRECISION NOT NULL,
    "boleto" VARCHAR(100) NOT NULL,
    "cnpj_beneficiario" TEXT NOT NULL,
    "numero_processo" TEXT NOT NULL,

    CONSTRAINT "custas_judiciais_pkey" PRIMARY KEY ("codigo")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- AddForeignKey
ALTER TABLE "advogados" ADD CONSTRAINT "advogados_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "advogados" ADD CONSTRAINT "advogados_cnpj_escritorio_advocacia_fkey" FOREIGN KEY ("cnpj_escritorio_advocacia") REFERENCES "escritorios_advocacia"("cnpj") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "pessoa_fisica" ADD CONSTRAINT "pessoa_fisica_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pessoa_juridica" ADD CONSTRAINT "pessoa_juridica_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "administradores" ADD CONSTRAINT "administradores_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "telefones_usuarios" ADD CONSTRAINT "telefones_usuarios_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "defesas" ADD CONSTRAINT "defesas_id_advogado_fkey" FOREIGN KEY ("id_advogado") REFERENCES "advogados"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "defesas" ADD CONSTRAINT "defesas_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "telefones_escritorios" ADD CONSTRAINT "telefones_escritorios_cnpj_escritorio_fkey" FOREIGN KEY ("cnpj_escritorio") REFERENCES "escritorios_advocacia"("cnpj") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "processos_juridicos" ADD CONSTRAINT "processos_juridicos_id_advogado_fkey" FOREIGN KEY ("id_advogado") REFERENCES "advogados"("id_usuario") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE "processos_juridicos" ADD CONSTRAINT "processos_juridicos_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE "processos_juridicos" ADD CONSTRAINT "processos_juridicos_cnpj_beneficiario_fkey" FOREIGN KEY ("cnpj_beneficiario") REFERENCES "beneficiarios"("cnpj") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE "beneficiarios_estaduais" ADD CONSTRAINT "beneficiarios_estaduais_cnpj_beneficiario_fkey" FOREIGN KEY ("cnpj_beneficiario") REFERENCES "beneficiarios"("cnpj") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "beneficiarios_federais" ADD CONSTRAINT "beneficiarios_federais_cnpj_beneficiario_fkey" FOREIGN KEY ("cnpj_beneficiario") REFERENCES "beneficiarios"("cnpj") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "custas_judiciais" ADD CONSTRAINT "custas_judiciais_cnpj_beneficiario_fkey" FOREIGN KEY ("cnpj_beneficiario") REFERENCES "beneficiarios"("cnpj") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE "custas_judiciais" ADD CONSTRAINT "custas_judiciais_numero_processo_fkey" FOREIGN KEY ("numero_processo") REFERENCES "processos_juridicos"("numero") ON DELETE RESTRICT ON UPDATE RESTRICT;
