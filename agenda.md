# ENVI on the GBDX platform

## Agenda

1. GBDX Prerequisites
2. Demo Software
2. Overview of GBDX ENVI Tasks
3. Demo of IDL workflow
4. Demo of ENVI workflow
5. Questions? Clarifications?

## GBDX Prerequisites

* Knowledge in the use of GBDX tasks and workflows. See [docs.gbdtaskdeveloperguide.apiary.io](http://docs.gbdtaskdeveloperguide.apiary.io).
* GBDX Account credentials for getting authentication tokens.
* Access to an S3 location for both reading and writing.

## Demo Software

* Atom text editor for editing files. (https://atom.io/)
* Postman for sending requests to GBDX endpoints. (https://www.getpostman.com/)

## Overview of GBDX ENVI Tasks:

### Difference between `tdgp/idl_task_runner` and `tdgp/envi_task_runner`

These are the two Docker containers that power the two different ways to execute ENVI tasks on the GBDX platform. Each have a few key properties to understand.

#### tdgp/idl_task_runner

This Docker container for running arbitrary IDL code on the GBDX platform. This runner is essentially a wrapper that executes the provided IDL program code. All ENVI tasks will be in the IDL program (by the user).

+ The container uses 2 generic inputs, `input_location` and `idl_program_data`.
+ The container uses 1 generic output, `output_location`.
+ There are requirements for the IDL code to run correctly, they are outlined in the usage documents for this task.
+

#### tdgp/envi_task_runner

This Docker container is for running single ENVI tasks. The single task executes and completes the same as any GBDX task. Doesn't require any IDL knowledge, can mix with non-ENVI GBDX tasks.

+ The containers inputs and outputs are mapped to the inputs and outputs of the ENVI task according to that task's definition, see the [ENVI online documentation](http://www.exelisvis.com/docs/ENVITask.html) for details on the task's parameters.
+ On top of the ENVI task's parameters, there is one parameter required for the GBDX platform:
    - ***task_name***: This parameter is GBDX and is required to identify which ENVI task is being executed. This name has to be the exact name of the task, see [ENVITask Documentation](http://www.exelisvis.com/docs/ENVITask.html) for a full list of task names.

### Demo of IDL

1. Overview *ENVISpectralIndexTask*, and similar tasks
2. Overview of *ndvi.pro* script
2. Overview of GBDX IDL task definition
2. IDL Task usage documentation overview
	+ https://github.com/TDG-Platform/envi-tasks/blob/dev/docs/idl_task_runner.md
5. Review S3 input data locations, used for this demo
6. Submit workflow, and Check events
8. Download output from S3 for viewing

### Demo of ENVI

1. Overview *ENVITask*, and similar tasks
2. Overview of GBDX ENVI task definition
2. ENVI Task usage documentation overview
	+ https://github.com/TDG-Platform/envi-tasks/blob/dev/docs/envi_task_runner.md
5. Review S3 input data locations, used for this demo
6. Submit workflow, and Check events
8. Download output from S3 for viewing





































hi
