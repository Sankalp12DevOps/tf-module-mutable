resource "null_resource" "prov"{
  count      =  var.OD_COUNT + var.SP_COUNT

   provisioner "remote-exec" {
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     =  element(local.PRIVATE_IDS,count.index)
  }
    inline = [
      "ansible-pull -U https://github.com/Sankalp12DevOps/sample.git ansible/component-pull.yml -e ENV=${var.ENV} -e COMPONENT=${var.COMPONENT} -e vVERSION=v${var.APP_VERSION}"
    ]
  }
}
