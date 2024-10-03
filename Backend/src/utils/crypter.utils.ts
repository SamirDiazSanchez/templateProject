import crypto from 'crypto';

export class Crypter {
	private static algorithm = 'aes-256-cbc';

	public static encrypt(text: string) : string {
		const key = process.env.KEY && Buffer.from(process.env.KEY);
		const iv = process.env.IV && Buffer.from(process.env.IV);

		if (key && iv) {
			const cipher = crypto.createCipheriv(this.algorithm, key, iv);
			let encrypted = cipher.update(text, 'utf8', 'hex');
			encrypted += cipher.final('hex');
			const response = Buffer.from(encrypted).toString('base64');
			return response;
		}
		else throw Error('cypher parameters are required');
	}

	public static decrypt(text: string) : string {
		const key = process.env.KEY && Buffer.from(process.env.KEY);
		const iv = process.env.IV && Buffer.from(process.env.IV);
		const encryptedText = Buffer.from(text, 'base64').toString('utf8');

		if (key && iv) {
			const decipher = crypto.createDecipheriv(this.algorithm, key, iv);
			let decrypted = decipher.update(encryptedText, 'hex', 'utf8');
			decrypted += decipher.final('utf8');
			return decrypted;
		}
		else throw Error('cypher parameters are required');
	}
}