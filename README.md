# Robust Ball & Beam

![Ball & Beam System](./Quanser%20BB01.png)

As part of the INEL 5595 - Special Topics (Robust Control Systems) course, we are working on designing a robust controller for the Quanser BB01 Ball & Beam System through loop-shaping methods and the MATLAB Robust Controls Systems toolbox.

We will divide the project into the following steps:

 1. [X] [**Modeling the plant $\tilde{G_p}(s)$**](./(01)modeling-plant): We use parameter tolerances established by the manual to develop simple uncertain models. We continue adding other effects like motor inductance and the SS01 Remote Sensor filters. Finally, we developed a nonlinear Simulink model and linearized it while preserving uncertainties.
 3. [X] [**Determining perturbation bounds $l_m(jω)$**](.): We used help from Rohrs, Melsa, and Schultz, and received inspiration from other papers to determine the multiplicative perturbation bounds.
 4. [X] [**Determining performance characteristics $p(jω)$**](.): We determined the performance characteristics of the system through the performance function. Again, we used the help of Rohrs, Melsa, and Schultz.
 5. [ ] [**Design Controller $G_c(s)$**](): Using loop-shaping methods learned in class, we will use the results from the previous steps to design the robust controller.
 6. [X] [**Develop VI**](): We need a Quanser VI before running tests on the physical Ball & Beam system. We used Simulink for this purpose as we have done in previous courses.
 7. [ ] [**Test & Iterate in Simulation**](): After designing the controller, we will simulate it to ensure that we get the desired performance (at least through simulation).
 8. [ ] [**Test & Iterate in Practice**](): The final step is to test the simulated controller in the physical system and ensure it meets the performance criteria.


## References
* C. E. Rohrs, J. L. Melsa, D. G. Schultz, and J. L. Melsa, Linear Control Systems. New York: McGraw-Hill, 1993.
* [Manuals](./manuals/IEEE%20References.md)
* [Papers](./papers/IEEE%20References.md)