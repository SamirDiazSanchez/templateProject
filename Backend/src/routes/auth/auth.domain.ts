import { ISqlType, VarChar } from 'mssql';

export class AuthDomain {
  email: string;
  password: string;

  constructor(email: string, password: string) {
    this.email = email;
    this.password = password;
  }

  obtenerParametrosParaSP(): { [key: string]: { tipo: ISqlType, value: any } } {
    return {
      email: { tipo: VarChar(200), value: this.email },
			password: { tipo: VarChar(200), value: this.password }
    };
  }
}