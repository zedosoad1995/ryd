import { CustomError } from "./CustomError";

export class UnauthorizedError extends CustomError {
  statusCode = 401;

  constructor(public message: string = "Unauthorized") {
    super(message);

    Object.setPrototypeOf(this, UnauthorizedError.prototype);
  }

  serializeErrors() {
    return { message: this.message };
  }
}
