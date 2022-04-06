# Parallel Programming for Multicore and Multi-CPU Machines

## 1. Multicore and Multi-CPU shared memory systems. 
Describe the architecture which can be considered as MIMD architecture. Each thread/core has its own execution context and program counter. All threads/core shared memory, which could be NUMA, etc.. 
About 1-2 pages, have some figures for the multicore/multi-CPU shared memory systems. System approach of parallel programming for this architecture, e.g. using pthread. 
Divide into paragraphs and identify the content for each paragraph
#### What are the Multi-core and multi-CPU architectures
#### Cache-coherent shared memory for multi-core and multi-CPU architecture, focusing on the NUMA aspect, shared memory aspect, and memory consistency model. The implication of shared memory to performance, e.g. false-sharing issue, memory bandwidth challenges, synchronization cost 
#### PThread programming models used so far and for a long time. + and - of pthreads
#### Synchronization between threads and cores, e.g. mutual exclusion, etc

## 2. Creating SPMD parallelism using OpenMP parallel and teams directive
#### Controlling number of threads and teams
#### Diverge the work for threads using mask directive and omp_get_thread_num
#### Synchronization of threads using barrier and order directive

## 3. Asynchronous tasking 

## 4. Explicit distribution of work using single, sections, workshring-loop, and distribute construct
