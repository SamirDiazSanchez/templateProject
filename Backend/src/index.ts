import cookieParcer from "cookie-parser";
import cors from "cors";
import dotenv from "dotenv";
import express, { Application, json } from "express";
import { ErrorMiddleware } from "middlewares/error.middleware";
import logger from "morgan";
import authController from "routes/auth/auth.controller";
import EncryptedController from 'routes/encrypted/encrypted.controller';
import userController from "routes/user/user.controller";
import { AppSettings } from "utils/appSettings.utils";

dotenv.config();
AppSettings.getSettings();

const app: Application = express();

app.use(json());
app.use(cors(AppSettings.cors));
app.use(cookieParcer());
app.use(logger('dev'));

app.use('/api/auth', authController);
app.use('/api/user', userController);
app.use('/api/encrypted', EncryptedController);

app.use(ErrorMiddleware);

app.listen(AppSettings.port, () => console.log(`Listen in http://localhost:${AppSettings.port}`));