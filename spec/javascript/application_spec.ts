import {expect, it} from "vitest";
import "app/javascript/application";

it("disables Turbo", () => {
  expect(Turbo.session.drive).toBe(false);
});
