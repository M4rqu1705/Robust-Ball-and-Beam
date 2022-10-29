clear all;
close all;
clc;

is_main = "startup";

addpath("(01)modeling-plant");
fprintf("[>>] Running `(01)modeling-plant`\n");
main01;

addpath("(02)perturbation-bounds");
fprintf("[>>] Running `(02)perturbation-bounds`\n");
main02;

addpath("(03)performance-characteristics");
fprintf("[>>] Running `(03)performance-characteristics`\n");
main03;

addpath("(04)contoller-design");
fprintf("[>>] Running `(04)contoller-design`\n");
main04;

clear is_main;