clear all;
close all;
clc;

is_main = "startup";

addpath("(01)modeling-plant")
main01;
addpath("(02)perturbation-bounds")
main02;
addpath("(03)performance-characteristics")
main03;
addpath("(04)contoller-design")
main04;

clear is_main;