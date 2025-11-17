  /*
   * file: Problem2.java
   * author: Richard Vultaggio 10/9
   * course: CMPT 435
   * assignment: 4
   * 
   * This file contains the skeleton code of  
   * Problem 2.
   */
public class Problem2 {

	public static int[] findmaxdiffrec (int[] A,int bottom, int top)
	{
		// Complete the method to find the maximum difference between points in A[] so that the larger value appears after the smaller value in A[]
		// Feel free to change the return type, parameters of the method
		// Full credit (30 points) will be awarded for a divide-and-conquer algorithm in O(n) time. 
		// Algorithms that are NOT divide-and-conquer or slower than O(n) time will be scored out of 10 points.

		if(bottom == top)//base case
		{
			return new int[]{A[bottom],A[bottom],0};//only one item
		}

		int m = (bottom + top)/2;//find mid for modified binarys earch

		int[] l = findmaxdiffrec(A,bottom,m); //left for "binary search"
		int[] r = findmaxdiffrec(A,m+1,top);//right for "binary search"

		int maxDiff = Math.max(Math.max(l[2],r[2]),r[1]-l[0]);//compare the max in just l, just r, and along both arrays
		int min;
		int max;
		if(l[0]>r[0]) //find min of both arrays
		{
			min= r[0];
		}
		else
		{
			min = l[0];
		}
		if(l[1]>r[1])//find max of both arrays
		{
			max= l[1];
		}
		else
		{
			max = r[1];
		}

		return new int[]{min,max,maxDiff}; //return current min and max, and max difference in an array

	}

	public static int findmaxdiff(int[] A) //function to take in array, use recursion, the output int
	{
        return findmaxdiffrec(A, 0, A.length - 1)[2];
    }
	
	
	
	public static void main(String[] args) {
		// Test your findmaxdiff() method here
		int[] testarray1 = {2, 3, 10, 6, 4, 8, 1};
		// maxdiff: 8
		// Add your test statement of findmaxdiff ()
		System.out.println(findmaxdiff(testarray1));
		
		
		int[] testarray2 = {7, 9, 1, 6, 3, 2};
		// maxdiff: 5
		// Add your test statement of findmaxdiff ()
		System.out.println(findmaxdiff(testarray2));

		int[] testarray3 = {1, 2, 3, 4, 5};
		System.out.println(findmaxdiff(testarray3)); // 4


		int[] testarray4 = {10, 9, 8, 7};
		System.out.println(findmaxdiff(testarray4)); // 0


		int[] testarray5 = {5, 5, 5, 5};
		System.out.println(findmaxdiff(testarray5)); // 0


		int[] testarray6 = {42};
		System.out.println(findmaxdiff(testarray6)); // 0
}
		
		
	}

