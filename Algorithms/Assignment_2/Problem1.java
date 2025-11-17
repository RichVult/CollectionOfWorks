  /*
   * file: Problem1.java
   * author: Richard Vultaggio 9/25
   * course: CMPT 435
   * assignment: 2
   * 
   * This file contains the skeleton code of  
   * Problem 1.
   */
   
public class Problem1 {

	public static int bin_search_first(double[] A, double search)//modified binary search to find first index of target
	{
		
		int l = 0;
        int r = A.length - 1;
		int location = -1;
        
        while (l <= r) {
            int mid = l + (r - l) / 2; 
            
            if (A[mid] == search) { //if found, save index and keep looking left for earlier values
                location = mid;
				r = mid - 1; 
            } else if (A[mid] < search) {
                l = mid + 1; 
            } else 
                r = mid - 1; 
		}	

		return location;
	}

	public static int bin_search_last(double[] A, double search)//modified binary search to find last index of target
	{
		
		int l = 0;
        int r = A.length - 1;
		int location = -2;
        
        while (l <= r) {
            int mid = l + (r - l) / 2; 
            
            if (A[mid] == search) {//if found, save index and keep looking right for later values
                location = mid;
				l = mid + 1; 
            } else if (A[mid] < search) {
                l = mid + 1; 
            } else 
                r = mid - 1; 
		}	

		return location;
	}
	


	public static int count(double[] A, double x)//use other two methods and subtract to find total
	{
		int fir = (bin_search_first(A,x));
		int sec = bin_search_last(A,x);
		return sec + 1 - fir;
	}
	

	
	public static void main(String[] args) {
		// test your count() method here
		
		double[] testarray = {1.3, 2.1, 2.1, 2.1, 2.1, 6.7, 7.5, 7.5, 8.6, 9.0};
		double t1 = 2.1;
		double t2 = 7.5;
		double t3 = 1.3;
		double t5 = 1.1;
		double t6 = 9.0;
		System.out.println(t1+" appears "+ count(testarray, t1) + " times");
		// 4 expected
		System.out.println(t2+" appears "+ count(testarray, t2) + " times");
		// 2 expected 
		System.out.println(t3+" appears "+ count(testarray, t3) + " times");
		// 1 expected
		System.out.println(t1+" appears "+ count(testarray, t5) + " times");
		// 0 expected
		System.out.println(t2+" appears "+ count(testarray, t6) + " times");
		// 1 expected 
		double[] testarray1 = {};//test empty array
		double t4 = 5.0;
		System.out.println(t4+" appears "+ count(testarray1, t4) + " times");
		// 0 expected
	}

}

