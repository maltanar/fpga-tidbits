#include <iostream>
#include <opencv2/opencv.hpp>
using namespace std;

#include "ExampleGrayScale.hpp"
#include "platform.h"

bool Run_ExampleGrayScale(WrapperRegDriver * platform, unsigned char *rgb_image, int rgb_size, unsigned char *grayscale_image) {
	ExampleGrayScale t(platform);
	int rgb_size_aligned = (rgb_size >> 3) << 3;
    int grayscale_size = rgb_size/3;
    int grayscale_size_aligned = (grayscale_size >> 3) << 3;
	cout << "Signature: " << hex << t.get_signature() << dec << endl;
	cout << "Running Grayscale accelerator on image of size " <<rgb_size_aligned <<" Bytes" <<endl;

	void * accelBuf = platform->allocAccelBuffer(rgb_size_aligned);
	void * accelBufRes = platform->allocAccelBuffer(grayscale_size_aligned);
	platform->copyBufferHostToAccel(rgb_image, accelBuf, rgb_size_aligned);

	t.set_baseAddr((AccelDblReg) accelBuf);
	t.set_resBaseAddr((AccelDblReg) accelBufRes);
	t.set_byteCount(rgb_size_aligned);
	t.set_resByteCount(grayscale_size_aligned);

	t.set_start(1);

    cout << "Waiting for Accel" <<endl;
	while(t.get_finished() != 1);
    cout << "Accel done" <<endl;
	unsigned int cc = t.get_cycleCount();
	cout << "#cycles = " << cc << " cycles per word = " << endl;
	platform->copyBufferAccelToHost(accelBufRes, grayscale_image, grayscale_size_aligned);
	t.set_start(0);
	return true;
}

int main(int argc, char **argv)
{
  if(argc != 2) {
        std::cout << "Usage: ./program_name image_path" << std::endl;
        return -1;
    }

    cv::Mat image = cv::imread(argv[1], cv::IMREAD_COLOR);

    if(!image.data) {
        std::cout << "Error loading the image" << std::endl;
        return -1;
    }

    int width = image.cols;
    int height = image.rows;
    int rgb_size = height*width*3;

    // Create C-style arrays for the image and grayscale data
    unsigned char* rgb_data = new unsigned char[rgb_size];
    unsigned char* grayscale_data = new unsigned char[height * width];

    int idx_rgb = 0;
    int idx_gray = 0;

    for(int i = 0; i < height; i++) {
        for(int j = 0; j < width; j++) {
            unsigned char b = image.at<cv::Vec3b>(i, j)[0];
            unsigned char g = image.at<cv::Vec3b>(i, j)[1];
            unsigned char r = image.at<cv::Vec3b>(i, j)[2];
            rgb_data[idx_rgb++] = r;
            rgb_data[idx_rgb++] = g;
            rgb_data[idx_rgb++] = b;
        }
    }

	WrapperRegDriver * platform = initPlatform();

	Run_ExampleGrayScale(platform, rgb_data, rgb_size, grayscale_data);

	deinitPlatform(platform);

    // Convert the grayscale_data back to a cv::Mat for saving
    cv::Mat grayscale_image(height, width, CV_8U, grayscale_data);
    cv::imwrite("grayscale_output.jpg", grayscale_image);

    delete[] rgb_data;
    delete[] grayscale_data;

	return 0;
}
