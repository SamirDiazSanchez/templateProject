import { NextFunction, Request, Response } from "express";

export const ErrorMiddleware = (err: any, _req: Request, res: Response, next: NextFunction) : any => {
  console.log(err)
  if (err) {
    return res.status(500).json({
      message: err
    });
  }

  next();
};
