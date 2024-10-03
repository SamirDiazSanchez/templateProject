import jwt from "jsonwebtoken";
import { AppSettings } from "utils/appSettings.utils";

export const getAccessToken = (claims: object = {}) => jwt.sign(claims, AppSettings.jwt.secretKey, { expiresIn: '1h' });
export const getRefreshToken = (claims: object = {}) => jwt.sign(claims, AppSettings.jwt.refreshKey, { expiresIn: '1d' });