# About #
a thumbnail service which exposes a single endpoint:
    GET /thumbnail?url=<url>​&width=<width>​&height=<height>
    Or with an explicit response image <format>
    GET /thumbnail?url=<url>​&width=<width>​&height=<height>&format=<jpg|jpeg|png|gif>

The service fetch the image located at the given url and return a resized version (based on the given dimensions) in the original format.
The image is scaled down to fill the given width and height while retaining the original aspect ratio and with all of the original image visible. If the requested dimensions are bigger than the original image's, the image doesn’t scale up. If the proportions of the original image do not match the given width and height, black padding is added to the image to reach the required size.
  
# Setup #
#### Prerequisite ####
Setup Docker: [Instructions](https://docs.docker.com/engine/installation/)

#### Run ####
    make up

The service is available at:
    
    http://localhost:9292
    


Usage example:
 1. Image: https://www.maketecheasier.com/assets/uploads/2016/09/adobe-alternative-linux-featured.jpg
 2. Encode the URL using: https://meyerweb.com/eric/tools/dencoder/ :
    https%3A%2F%2Fwww.maketecheasier.com%2Fassets%2Fuploads%2F2016%2F09%2Fadobe-alternative-linux-featured.jpg
 3. Image size: Width: 800, Height: 400
 4. Call out local service:
    http://localhost:9292/thumbnail?url=https%3A%2F%2Fwww.maketecheasier.com%2Fassets%2Fuploads%2F2016%2F09%2Fadobe-alternative-linux-featured.jpg&width=800&height=400

#### Test ####
    make tests

    
#### Access Shell ####
    make shell

#### Known Issues ####
 - Wrong handling of images with transparent background
    
#### TODO ####
 - Cover controller with u-test
