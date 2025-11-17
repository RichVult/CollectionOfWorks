  /*
   * file: Problem1.java
   * author: Richard Vultaggio 9/4
   * course: CMPT 435
   * assignment: 1
   * 
   * This file contains the skeleton code of  
   * Problem 1.
   */
public class Problem1 {
	


	public static void rearrange(int[] A)
	{
		int[] B = new int[A.length]; //Create a new array to copy onto
		int counter = 0;//A counter to parse through our new array
		for(int i = 0; i < A.length; i += 2)//This will parse through the first, lower, half of array A, assigning all lower values to even numbers of array B
		{
			B[i] = A[counter];//counter goes up by one, while i will alternate, only assigning to the even numbers
			counter++;
		}
		for(int k = 1; k < A.length; k += 2)//This will parse through the second, larger, half of the array, assigning all higher values to odd numbers
		{
			B[k] = A[counter];
			counter++;
		}

		for(int q = 1; q < A.length; q++)//Assign the correct, rearranged array B to array A
		{
			A[q]=B[q];
		}
		
	}


		/*
		Input: an array, A, of n sorted integers (positive, negative, or 0) that 
		A[0] <= A[1] <= A[2] <= ... <= A[n-2] <= A[n-1]
	
		Output: re-arrange elements in A such that: 
		Element at even position (i.e., A[0], A[2]) are less than or equal to both of its neighbors
		Element at odd position (i.e., A[1], A[3]) are greater than or equal to both of its neighbors
	
		A[0] <= A[1] >= A[2] <= A[3] >= A[4] <= A[5] >= A[6] ...
		
		Design an algorithm that solves this problem.
		 */
		
		//Complete this method
		

		
	
	
	public static void main(String[] args) {
		
		// Test your rearrange() method
		// Test case 1
		
		int[] A = {13, 20, 45, 69, 78, 100, 127, 155};
		
		System.out.println("Before:");
		
		for(int i=0; i < A.length; i++)
		{
			System.out.print(A[i]+" ");
		}
		
		rearrange(A);
		
		System.out.println("\nAfter:");
		
		for(int i=0; i < A.length; i++)
		{
			System.out.print(A[i]+" ");
		}

		int[] C = {0}; //test with only one element
		
		System.out.println("Before:");
		
		for(int i=0; i < C.length; i++)
		{
			System.out.print(C[i]+" ");
		}
		
		rearrange(C);
		
		System.out.println("\nAfter:");
		
		for(int i=0; i < C.length; i++)
		{
			System.out.print(C[i]+" ");
		}


		int[] D = {}; //test with no elements
		
		System.out.println("Before:");
		
		for(int i=0; i < D.length; i++)
		{
			System.out.print(D[i]+" ");
		}
		
		rearrange(D);
		
		System.out.println("\nAfter:");
		
		for(int i=0; i < D.length; i++)
		{
			System.out.print(D[i]+" ");
		}
		
		int[] E = {2,2,2,2,2,2,2}; //test with identitical elements
		
		System.out.println("Before:");
		
		for(int i=0; i < E.length; i++)
		{
			System.out.print(E[i]+" ");
		}
		
		rearrange(E);
		
		System.out.println("\nAfter:");
		
		for(int i=0; i < E.length; i++)
		{
			System.out.print(E[i]+" ");
		}

		int[] F = {-33,22,111,112,200,222,300}; //test with odd # of elements
		
		System.out.println("Before:");
		
		for(int i=0; i < F.length; i++)
		{
			System.out.print(F[i]+" ");
		}
		
		rearrange(F);
		
		System.out.println("\nAfter:");
		
		for(int i=0; i < F.length; i++)
		{
			System.out.print(F[i]+" ");
		}
	}
}
