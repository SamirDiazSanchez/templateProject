export class JsonHandler {
	public static isJson(content: string) {
		if (!content || typeof content != "string") throw new Error('Invalid input content');
		
		try {
			JSON.parse(content);
			return true;
		}
		catch (ex) {
			return false;
		}
	}

	public static toJson(content: string) {
		try {
			this.isJson(content);
			
			return JSON.parse(content);
		}
		catch (ex) {
			console.log(ex);
			throw new Error("");
			
		}
	}

	public static toString(content: any) {
		if (!content || typeof content == "string") throw new Error('Invalid input content');
		
		try {
			return JSON.stringify(content);
		}
		catch (ex) {
			throw new Error("Error parce content");
		}
	}
}