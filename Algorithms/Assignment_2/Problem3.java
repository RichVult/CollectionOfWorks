  /*
   * file: Problem3.java
   * author: Richard Vultaggio 9/25
   * course: CMPT 435
   * assignment: 2
   * 
   * This file contains the skeleton code of  
   * Problem 3.
   */
public class Problem3 {

	public static int findk(int[] A)
	{
		// Given an array A[] of n distinct and sorted numbers that has been circularly shifted k positions to the right
		// Assume k is unknown, find k
		// Complete the method findk() here
		// O(log n) time expected
		// Algorithms slower than O(logn) will be graded out of 10 points
		// Feel free to change the return type or parameters
		if(A.length == 0){ //check empty array
			return 0;}
		int l = 0;
        int r = A.length - 1;
		if (A[l] < A[r]){ //check if array is not rotated
			return 0;
		}
		
        while (l <= r) {//modified binary search
            int mid = l + (r - l) / 2; 
            
			if(mid != 0){//make sure not to check A[-1]
				if (A[mid] > A[mid-1]) {
					if(A[mid] < A[r]){
						r = mid -1;
					}
					else {
						l = mid + 1;
					}
				}
				else//if out of order, location of rotation is found
					return mid;
			}
			else{
				if(r == 1)//check for fringe cases
					return r;
				return mid;
			}	
		}
		return 0;
	}
	

	
	public static void main(String[] args) {
		// test your findk() method here
		
		int[] testarray = {35, 42, 5, 15, 27, 29};
		int[] testarray1 = {5, 15, 27, 29};
		int[] testarray2 = {4,5,6,7,8,9,1,2,3};
		int[] testarray3 = {27, 29, 35, 42, 5, 15};
		int[] testarray4 = {5, 1, 2, 3, 4};
		int[] testarray5 = {};
		int[] testarray6 = {1};

		System.out.println("The input sorted array that has been circularly shifted k = "+ findk(testarray) + " positions.");
		// 2 expected
		System.out.println("The input sorted array that has been circularly shifted k = "+ findk(testarray1) + " positions.");
		// 0 expected
		System.out.println("The input sorted array that has been circularly shifted k = "+ findk(testarray2) + " positions.");
		// 6 expected
		System.out.println("The input sorted array that has been circularly shifted k = "+ findk(testarray3) + " positions.");
		// 4 expected
		System.out.println("The input sorted array that has been circularly shifted k = "+ findk(testarray4) + " positions.");
		// 1 expected
		System.out.println("The input sorted array that has been circularly shifted k = "+ findk(testarray5) + " positions.");
		// 0 expected
		System.out.println("The input sorted array that has been circularly shifted k = "+ findk(testarray6) + " positions.");
		// 0 expected
	
		
	}

}
