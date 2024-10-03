import { Request, Response, Router } from "express";
import { Crypter } from 'utils/crypter.utils';
import { JsonHandler } from 'utils/jsonHandler.utils';

const router = Router();

router.post('/encrypt', (req: Request, res: Response) => {
	const text = req.body.text;

	const encryptedText = Crypter.encrypt(text);

	res
		.status(200)
		.json(encryptedText);
});

router.post('/decrypt', (req: Request, res: Response) => {
	const text = req.body.text;
	const decryptedText = Crypter.decrypt(text);

	res
		.status(200)
		.json(decryptedText);
});

router.get('/json', (req: Request, res: Response) => {
	const response = JsonHandler.toString(req.body)
	res
		.status(200)
		.json(response)
});

export default router;