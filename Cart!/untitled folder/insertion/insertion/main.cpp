//
//  main.cpp
//  insertion
//
//  Created by Semen Parhimchik on 2017-01-16.
//  Copyright © 2017 Parhim. All rights reserved.
//

#include <iostream>
#include <cstdlib>
#include "insertion.h"

using namespace std;

// insertion sort with several errors

// store command-line arguments in x[] array
void getArgs( int argc, char **argv ) {
    x_size = argc - 1;
    for( int i = 0; i < x_size; i++ )
        x[i] = atoi( argv[ i+1 ] );
}

void scootOver( int j ) {
    int k;
    int t = 99;
    for( k = y_size - 1; k >= j ; k-- ){
        t = y[k];
        y[k] = 0;
        y[k+1] = t;
    }

}


void insert( int xx ) {
    int j;
    
    
    if( y_size == 0 ) {
        y[0] = xx;
        return;
    }
    // Need to insert just before the first y element that xx is less than
    for( j=0; j< y_size; j++ ) {
        if( xx <= y[j] ) {
            // shift y[j], y[j+1], ... rightward before inserting xx
            scootOver( j );
            y[j] = xx;
            return;
        }
        if (xx > y[j] && j == y_size-1){
            y[j+1]=xx;
            
        }
        
    }
}

void processData() {
    for( y_size = 0; y_size < x_size; y_size++ )
        // insert x value in the proper place among y[0],....,y[y_size-1]
        insert( x[ y_size ] );
}

void printResults() {
    for( int i=0; i<y_size; i++ )
        cout << y[i] << " ";
    cout << endl;
}

int main( int argc, char ** argv ) {
    getArgs( argc, argv );
    processData();
    printResults();
}
