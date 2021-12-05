
resource "aws_subnet" "a" {
    vpc_id = var.vpc_id
    cidr_block = var.green_cidr_block
    map_public_ip_on_launch = true
    availability_zone = var.zones[0]
    tags = {
        Name = "1a"
    }
 
   
}

resource "aws_subnet" "b" {
    vpc_id = var.vpc_id
    cidr_block = var.blue_cidr_block
    map_public_ip_on_launch = true
   availability_zone = var.zones[1]
    tags = {
        Name = "1b"
    }
} 
resource "aws_subnet" "db" {
    vpc_id = var.vpc_id
    cidr_block = var.db_cidr_block
    map_public_ip_on_launch = true
   availability_zone = var.zones[2]
    tags = {
        Name = "db"
    }

    
} 

 resource "aws_db_subnet_group" "db" {
    subnet_ids = [aws_subnet.a.id, aws_subnet.b.id, aws_subnet.db.id]
    
    
}  

resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "gateway"
  }
}



data "aws_route_table" "selected" {
  vpc_id = var.vpc_id
}


resource "aws_route" "inet" {
  
  route_table_id            = data.aws_route_table.selected.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
}