import fs from 'fs';
import path from 'path';
import { CorsOptions } from 'cors';
import { JsonHandler } from './jsonHandler.utils';
import { Crypter } from 'utils/crypter.utils';

interface JwtSettings {
  secretKey: string,
  refreshKey: string
}

export class AppSettings {
  public static port: Number;
  public static cors: CorsOptions;
  public static defaultConnection: String;
  public static jwt: JwtSettings;

  public static getSettings() {
    try {
      const _appsettingsPath = path.join(__dirname, '../appsettings.json');
      const _rawData = fs.readFileSync(_appsettingsPath, 'utf-8');
      if (!_rawData) throw new Error("settings can not read");
      
      const _settings = JsonHandler.toJson(_rawData);
      if (!_settings.port || typeof _settings.port != 'number') throw new Error("Invalida setting parameter");
      if (!_settings.cors || typeof _settings.cors != 'object') throw new Error("Invalida setting parameter");
      if (!_settings.defaultConnection || typeof _settings.defaultConnection != 'string') throw new Error("Invalida setting parameter");
      if (!_settings.jwt || typeof _settings.jwt != 'string') throw new Error("Invalid setting parameter");

      const decryptedDefaultConnection = Crypter.decrypt(_settings.defaultConnection);
      const defaultConnection = JsonHandler.toJson(decryptedDefaultConnection);
      
      const decryptJwt = Crypter.decrypt(_settings.jwt);
      const jwt = JsonHandler.toJson(decryptJwt);
      
      this.port = _settings.port;
      this.cors = _settings.cors;
      this.defaultConnection = defaultConnection;
      this.jwt = jwt;
    }
    catch (ex) {
      throw new Error("Error load settings");
    }
  }
}
