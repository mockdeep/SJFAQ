import {resolve} from "node:path";
import {defineConfig} from "vitest/config";

const root = import.meta.dirname;

export default defineConfig({
  resolve: {
    alias: {
      channels: resolve(root, "app/javascript/channels"),
      controllers: resolve(
        root,
        "app/javascript/controllers",
      ),
      javascript: resolve(root, "app/javascript"),
    },
  },
  test: {
    environment: "jsdom",
    environmentOptions: {
      jsdom: {url: "http://test.host"},
    },
    globals: false,
    include: ["spec/javascript/**/*_spec.ts"],
    setupFiles: ["spec/javascript/test_helper.ts"],
  },
});
