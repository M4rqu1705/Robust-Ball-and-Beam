# Robust Ball & Beam

![Ball & Beam System](./Quanser%20BB01.png)

As part of the INEL 5595 - Special Topics (Robust Control systems) course we are working on designing a robust controller for the Quanser BB01 Ball & Beam System through loop-shaping methods and the MATLAB Robust Controls Systems toolbox.

We will divide the project into the following steps:

 1. [X] [**Modeling the uncertain system**](./n01_UncertainSystemModels.m): In this phase, we will only use tolerances established by the manual.
 2. [X] [**Modeling other effects**](./n02_NonlinearModelEquations.m): Using the models we developed in the previous step, we will add non-linearities like saturation to the motor input and other effects like the SS01 Remote Sensing unit's filter to a model. We will use Simulink for this purpose.
 3. [~] [**Linearizing the system**](./n03_Linearize.m): The new uncertain system will be linearized around an operating point to help find the upper limit for the multiplicative perturbances l_m(jω).
 4. [~] [**Determining performance characteristics**](./n04_PerformanceCharacteristics.m): The next step is to determine the performance characteristics of the system through the performance function p(jω).
 5. [ ] [**Design Controller**](): Using loop-shaping methods learned in class, we will use the results from the previous steps to design the robust controller.
 6. [ ] [**Develop VI**](): We need a Quanser VI before running tests on the physical Ball & Beam system. We will use Simulink for this purpose, as we have done in previous courses.
 7. [ ] [**Test & Iterate in Simulation**](): After designing the controller, we will simulate it to ensure that we get the desired performance (at least through simulation). 
 8. [ ] [**Test & Iterate in Practice**](): The final step is to test the simulated controller in the physical system and ensure it meets the performance criteria.