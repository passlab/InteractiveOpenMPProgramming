{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "increased-working",
   "metadata": {},
   "source": [
    "# `parallel for`"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "plastic-innocent",
   "metadata": {},
   "source": [
    "A simple example using OpenMP `parallel for` directive:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "beginning-exhibition",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Thread: 0, i = 0\n",
      "Thread: 3, i = 6\n",
      "Thread: 1, i = 2\n",
      "Thread: 0, i = 1\n",
      "Thread: 1, i = 3\n",
      "Thread: 3, i = 7\n",
      "Thread: 4, i = 8\n",
      "Thread: 4, i = 9\n",
      "Thread: 2, i = 4\n",
      "Thread: 2, i = 5\n",
      "Thread: 5, i = 10\n",
      "Thread: 5, i = 11\n"
     ]
    }
   ],
   "source": [
    "//%compiler: clang\n",
    "//%cflags: -fopenmp\n",
    "\n",
    "#include <stdio.h>\n",
    "#include <stdlib.h>\n",
    "#include <omp.h>\n",
    "\n",
    "int main (int argc, char** argv) {\n",
    "    int i;\n",
    "    #pragma omp parallel for num_threads(6)\n",
    "    for (i = 0; i < 12; i++)\n",
    "        printf(\"Thread: %d, i = %d\\n\", omp_get_thread_num(), i);\n",
    "    \n",
    "    return 0;\n",
    "    \n",
    "    \n",
    "}"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "2cbe28a5-303a-4218-a8e2-28140a0a2bf2",
   "metadata": {},
   "outputs": [
    {
     "ename": "SyntaxError",
     "evalue": "invalid syntax (4041655708.py, line 1)",
     "output_type": "error",
     "traceback": [
      "\u001b[0;36m  Input \u001b[0;32mIn [1]\u001b[0;36m\u001b[0m\n\u001b[0;31m    //%load https://passlab.github.io/ITSC3181/exercises/sum/sum_full.c\u001b[0m\n\u001b[0m    ^\u001b[0m\n\u001b[0;31mSyntaxError\u001b[0m\u001b[0;31m:\u001b[0m invalid syntax\n"
     ]
    }
   ],
   "source": [
    "//%load https://passlab.github.io/ITSC3181/exercises/sum/sum_full.c\n",
    "/*\n",
    " * Sum of a*X[N]\n",
    " */\n",
    "#include <stdio.h>\n",
    "#include <stdlib.h>\n",
    "#include <math.h>\n",
    "#include <string.h>\n",
    "#include <sys/timeb.h>\n",
    "\n",
    "/* read timer in second */\n",
    "double read_timer() {\n",
    "    struct timeb tm;\n",
    "    ftime(&tm);\n",
    "    return (double) tm.time + (double) tm.millitm / 1000.0;\n",
    "}\n",
    "\n",
    "/* read timer in ms */\n",
    "double read_timer_ms() {\n",
    "    struct timeb tm;\n",
    "    ftime(&tm);\n",
    "    return (double) tm.time * 1000.0 + (double) tm.millitm;\n",
    "}\n",
    "\n",
    "#define REAL float\n",
    "#define VECTOR_LENGTH 102400\n",
    "\n",
    "/* initialize a vector with random floating point numbers */\n",
    "void init(REAL A[], int N) {\n",
    "    int i;\n",
    "    for (i = 0; i < N; i++) {\n",
    "        A[i] = (double) drand48();\n",
    "    }\n",
    "}\n",
    "\n",
    "REAL sum(int N, REAL X[], REAL a) {\n",
    "    int i;\n",
    "    REAL result = 0.0;\n",
    "    for (i = 0; i < N; ++i)\n",
    "        result += a * X[i];\n",
    "    return result;\n",
    "}\n",
    "\n",
    "int main(int argc, char *argv[]) {\n",
    "    int N = VECTOR_LENGTH;\n",
    "    double elapsed; /* for timing */\n",
    "    if (argc < 2) {\n",
    "        fprintf(stderr, \"Usage: sum <n> (default %d)\\n\", N);\n",
    "    } else N = atoi(argv[1]);\n",
    "    REAL *X = (REAL*)malloc(sizeof(REAL)*N);\n",
    "    REAL *Y = (REAL*)malloc(sizeof(REAL)*N);\n",
    "\n",
    "    srand48((1 << 12));\n",
    "    init(X, N);\n",
    "    init(Y, N);\n",
    "    REAL a = 0.1234;\n",
    "    /* example run */\n",
    "    elapsed = read_timer();\n",
    "    REAL result = sum(N, X, a);\n",
    "    elapsed = (read_timer() - elapsed);\n",
    "    printf(\"======================================================================================================\\n\");\n",
    "    printf(\"\\tSum %d numbers\\n\", N);\n",
    "    printf(\"------------------------------------------------------------------------------------------------------\\n\");\n",
    "    printf(\"Performance:\\t\\tRuntime (ms)\\t MFLOPS \\n\");\n",
    "    printf(\"------------------------------------------------------------------------------------------------------\\n\");\n",
    "    printf(\"Sum:\\t\\t\\t%4f\\t%4f\\n\", elapsed * 1.0e3, 2*N / (1.0e6 * elapsed));\n",
    "    return 0;\n",
    "}\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "a2404bb2-27e3-4290-99d8-87a656d485a2",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " Hello from process:            2\n",
      " Hello from process:            7\n",
      " Hello from process:            3\n",
      " Hello from process:            6\n",
      " Hello from process:            0\n",
      " Hello from process:            5\n",
      " Hello from process:            4\n",
      " Hello from process:            1\n"
     ]
    }
   ],
   "source": [
    "!!%compiler: gfortran\n",
    "!!%cflags: -fopenmp\n",
    "\n",
    "PROGRAM Parallel_Hello_World\n",
    "USE OMP_LIB\n",
    "\n",
    "!$OMP PARALLEL\n",
    "\n",
    "  PRINT *, \"Hello from process: \", OMP_GET_THREAD_NUM()\n",
    "\n",
    "!$OMP END PARALLEL\n",
    "\n",
    "END"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "70810ace-4201-4540-bb28-21aa74b74bf4",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Native",
   "language": "native",
   "name": "native"
  },
  "language_info": {
   "file_extension": ".c",
   "mimetype": "text/plain",
   "name": "c"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
