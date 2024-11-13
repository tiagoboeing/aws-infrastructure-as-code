data "terraform_remote_state" "route_table" {
  backend = "local"

  config = {
    path = "../../../generated/aws/route_table/terraform.tfstate"
  }
}
