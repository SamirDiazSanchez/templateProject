import { ISqlType, VarChar, DateTime, Bit } from 'mssql';

export class UserDomain {
	userId: string;
  email: string;
  userName: string;
	profileId: string;
	password: string;
	userCreated: string;
	userUpdated: string;
	created: Date;
	updated: Date;
	isActive: boolean;

  constructor(userId: string, email: string, userName: string, profileId: string, password: string, userCreated: string, userUpdated: string, created: Date, updated: Date, isActive: boolean) {
		this.userId = userId;
    this.email = email;
		this.userName = userName;
		this.profileId = profileId;
    this.password = password;
		this.userCreated = userCreated;
		this.userUpdated = userUpdated;
		this.created = created;
		this.updated = updated;
		this.isActive = isActive;
  }

  getSpParameters(): { [key: string]: { tipo: ISqlType, value: any } } {
    return {
			UserId: { tipo: VarChar(200), value: this.userId },
      Email: { tipo: VarChar(200), value: this.email },
      UserName: { tipo: VarChar(200), value: this.userName },
      ProfileId: { tipo: VarChar(200), value: this.profileId },
      Password: { tipo: VarChar(200), value: this.password },
      UserCreated: { tipo: VarChar(200), value: this.userCreated },
      UserUpdated: { tipo: VarChar(200), value: this.userUpdated },
      Created: { tipo: DateTime(), value: this.created },
      Updated: { tipo: DateTime(), value: this.updated },
      IsActive: { tipo: Bit(), value: this.isActive }
    };
  }
}