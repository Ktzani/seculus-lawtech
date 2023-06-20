import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from 'zod'
import { request } from "http";

export async function processosRoutes (app: FastifyInstance) {
    app.get()
}