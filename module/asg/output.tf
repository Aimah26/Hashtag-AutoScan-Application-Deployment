output "asg" {
    value = aws_autoscaling_group.asg.id
}

output "ami" {
    value = aws_ami_from_instance.ami.id
}