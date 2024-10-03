import { NextFunction, Response } from "express";
import jwt from "jsonwebtoken";
import { AppSettings } from "utils/appSettings.utils";

export const JwtMiddleware = (req: any, res: Response, next: NextFunction) => {
	const access_token = req.cookies?.access_token;
	try {
		const data = jwt.verify(access_token, AppSettings.jwt.secretKey);
		req.User = data;
		next();
	}
	catch (ex) {
		res.status(401).json({ message: 'Unaurhorize' });
	}
}