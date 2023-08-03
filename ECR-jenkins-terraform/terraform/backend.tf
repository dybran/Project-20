terraform {
	backend "s3" {
	bucket = "tooling"
	key = "tooling-terrastate/backend_s3"
	region = "us-east-1"
	}
}