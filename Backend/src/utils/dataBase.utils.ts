import sql from 'mssql';

export class DataBase {
	private _setting: any;

	constructor (connectionSetting: any) {
		console.log(connectionSetting)
		this._setting = connectionSetting;
	}

	private async connect() {
		try {
			console.log(this._setting)
			return await sql.connect(this._setting);
		} catch (ex) {
			throw ex;
		}
	}

	public async getList() {
		try {
			let pool = await this.connect();

			if (!pool) throw Error('Error to create connection');

			// const request = pool.request();

			// const rows = request.output('Rows', Int);
			// console.log(rows);

			// const resultado = await request.execute('Select_UserList');
			// await pool.close();

			return "resultado";
		}
		catch (ex) {
			throw ex;
		}
	}
}