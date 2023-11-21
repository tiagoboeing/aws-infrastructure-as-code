locals {
  function_name = join("-", [var.pool_name, var.function_name])
}