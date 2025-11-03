variable "project_name" {
    default = "Roboshop"
}
variable "environment" {
    default = "dev"
}
variable "sg_name" {
    type    =   map
}
variable  "description"{
    type    =   map
    default =   {}
}
variable "vpc_id" {
    type    =   map
}
variable "common_tags" {
    type    =   map
    default =   {}
}
variable "vpc_id"{
    type    =   map
}
