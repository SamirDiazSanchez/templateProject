import { CookieOptions, Response, Router } from "express";
import { getAccessToken, getRefreshToken } from "./auth.service";

const router = Router();

const cookieSettine = (maxAge: number): CookieOptions => ({
	httpOnly: true,
	secure: process.env.NODE_ENV == 'production',
	sameSite: 'strict',
	maxAge: maxAge * 60000
});

router.get("/", (_req, res: Response) => {
	const access_token = getAccessToken();
	const refresh_token = getRefreshToken();
	res
		.cookie('access_token', access_token, cookieSettine(5))
		.cookie('refresh_token', refresh_token, cookieSettine(60))
		.status(200)
		.json({ message: 'Success' });
	
	res.status(200).json();
});

export default router;