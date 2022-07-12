# Parallel Programming for Multicore and Multi-CPU Machines

## Introduction into Multicore and Multi-CPU machines

Moores's Law states CPUs double in frequency every two years. This was possible by increasing the transistor density. As time has gone on this has proven to be more difficult because with more transistors more heat is produced. As this problem became more apparent Computer Architects turned to another solution, a cheaper yet effective solution. Which was the implementation of multiple cores within a CPU. IBM was the first to release a Multi-core CPU back in 2001. Intel’s attempt to release processors of this caliber came in 2002 with the Intel Pentium 4. This processor didn’t implement parallel computing more or less just hyperthreading. This allowed it to switch between programs really fast so it gave the appearance of doing multiple processes at once. Since then more and more computers have been implementing multicore CPUs, some even have multiple CPUs. Because of this computer scientists needed to find a way to utilize these extra cores, thus was the birth of parallel computing. 


## 1. Multicore and Multi-CPU shared memory systems. 
Describe the architecture which can be considered as MIMD architecture. Each thread/core has its own execution context and program counter. All threads/core shared memory, which could be NUMA, etc.. 
About 1-2 pages, have some figures for the multicore/multi-CPU shared memory systems. System approach of parallel programming for this architecture, e.g. using pthread. 
Divide into paragraphs and identify the content for each paragraph
#### What are the Multi-core and multi-CPU architectures
#### Cache-coherent shared memory for multi-core and multi-CPU architecture, focusing on the NUMA aspect, shared memory aspect, and memory consistency model. The implication of shared memory to performance, e.g. false-sharing issue, memory bandwidth challenges, synchronization cost 
#### PThread programming models used so far and for a long time. + and - of pthreads
#### Synchronization between threads and cores, e.g. mutual exclusion, etc

MIMD architecture consists of processors that operate independently and asynchronously from one another. MIMD architecture systems consist of many processors that can have much common memory or memory that is exclusive to one. These terms mean many processes can execute instructions at any time with any piece or segment of data. MIMD architecture consists of two different types of architecture; Shared Memory MIMD architecture and Distributed Memory MIMD architecture. 

Shared Memory MIMD systems have the following characteristics. Shared Memory MIMD groups processors and memory. Any processor can access that memory through a communication channel designated by the programmer. Finally, the memory addresses are shared between processors. On the other hand, Distributed Memory MIMD systems have their own set of characteristics. One, memory and processors are grouped together in pairs known as processing elements. Which is linked to other PEs through the use of communication channels. Finally, each PE communicates with each other by sending messages, communication isn’t as open like that of a Shared Memory MIMD system. 


## 2. Creating SPMD parallelism using OpenMP parallel and teams directive
#### Controlling number of threads and teams
#### Diverge the work for threads using mask directive and omp_get_thread_num
#### Synchronization of threads using barrier and order directive

Open-MP allows for the creation of shared-memory parallel programs. In this Chapter, we will be discussing Single Program, Multiple Data, or SPMD for short.  SPMD style uses a number of individual processors or threads to carry out the same program or computation on different sets of data simultaneously. SPMD style parallel programming is an example of a low-level thread-specific programming style. Which can be identified by the following characteristics:


## 3. Asynchronous tasking 

## 4. Explicit distribution of work using single, sections, workshring-loop, and distribute construct
