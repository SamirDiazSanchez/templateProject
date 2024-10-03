// import { JwtMiddleware } from "middlewares/jwt.middleware";
import { Response, Router, NextFunction } from "express";
import { getAll } from "./user.service";

const router = Router();

router.get('/', async (_req, res: Response, next: NextFunction) => {
	try {
		const result = await getAll();
		res.status(200).json(result);
	}
	catch (ex) {
		next(ex);
	}
});

export default router;