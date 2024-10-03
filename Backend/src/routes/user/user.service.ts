import { DataBase } from "utils/dataBase.utils";
import { AppSettings } from "utils/appSettings.utils";

export const getAll = async () => {
	const connection = new DataBase(AppSettings.defaultConnection);

	return await connection.getList();
}