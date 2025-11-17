  /*
   * file: Problem1.java
   * author: Richard Vultaggio
   * course: CMPT 435
   * assignment: 6
   * 
   * This file contains the skeleton code of  
   * Problem 1.
   */

public class Problem1 
{
	
	public static void swap(int[] A, int i, int j)
	{
		int temp = A[i];
		A[i] = A[j];
		A[j] = temp;
		
	}
	
	//The original partition function
	public static int partition(int[] A, int s, int e)
	{
		int pivot = A[s];
		int i = s + 1;
		int j = e;

		while (i<=j)
		{
			while (i < e & A[i] < pivot) 
				i = i + 1;
		
			while(j > s & A[j] >= pivot) 
				j = j - 1;
		
			if (i >= j) 
				break;
		
			swap(A, i, j);			
			
		}

			swap(A, s, j);
			return j;

	}
	
	
	
		
	
	public static int[] mpartition(int[] A, int s, int e)
	{
		//Permute the elements of A[s, . . ., e] and return two indices p and q, where s ≤ p ≤ q ≤ e, such that
		//• all elements of A[p, . . ., q] are equal,
		//• each element of A[s, . . ., p−1] is less than A[p], and
		//• each element of A[q+1, . . ., e] is greater than A[p].
		//Complete the function
		//Feel free to change the return type and parameters

		int pivot = A[s];
		int i = s + 1;//main pointer
		int j = s;//lower bound
		int k = e;//upper bound
		int[] ret;

		while (i<=k)//go until main pointer reached end bound
		{
			if(A[i] < pivot)//check if main pointer is lower than pivot
			{
				swap(A,i,j);//swap pointer and old lower bound
				i++;//iterate both pointer and lower bound
				j++;
			}			
			else if(A[i] > pivot)//if main pointer is higher than pivot
			{
				swap(A,i,k);//swap main pointer and old upper boound 
				k--;//de iterate upper bound
			}			
			else
			{
				i++;//if pointer is at pivot or equal to pivot, iterate
			}
		}
		ret = new int[]{j,k};
		return ret;
	}

	
	public static void main(String[] args) 
	{
		
		// Test case 
		
		int[] testarray1 = {1, 2, 4, 1, -5, -2, 0, 6, 3, 1, 7, 8};
		
		mpartition(testarray1, 0, testarray1.length-1);
			
		//Output the array after the partition
		for(int i = 0; i < testarray1.length; i++)
		{
			System.out.print(testarray1[i] + " ");
		}
		// -5 0 -2 1 1 1 2 6 3 4 7 8 expected
		
	}//main
}//Problem2
