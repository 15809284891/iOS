//
//  Sort.m
//  算法_Demo
//
//  Created by karisli(李雪) on 2021/4/12.
//

#import "Sort.h"
void swapEle(int *a,int *b){
    *a = *a + *b;
    *b = *a - *b;
    *a = *a - *b;
}

void printList(int a[],int n){
    printf("\n");
    int i;
    for (i=0; i<n; i++) {
        printf(" %d ",a[i]);
    }
    printf("\n");
}
/** 冒泡排序
 * 原理：(比较的是无序集合：经过冒泡之后后面的元素已经有序，因此不再比较，所以无序集合的范围会缩小)
 * 1. 每次都比较集合的无序集合的相邻元素的优先级，发现优先级不一致就进行交换
 * 2. 一轮下来，当前无序集合的最大或者最小元素就会被交换到最后面。
 * 空间复杂度 o(1)
 * 时间复杂度：最好情况O(n),最坏情况O(n^2)
 
 */
void bubbleSort(int a[],int n){
    int i,j;
    //-1：减少一次循环，因为后面如果有序了，最后一个就不用排了
    for(i=0;i<(n-1);i++){
        //flag：减少外循环次数如果flag没有等于1，说明未发生交换，所有的已经有序，就可以终止了
        int flag = 0;
        //-i：减少比较次数，因为后面的已经有序，不需要再继续比较
        //j：这里必须从1开始，因为里面使用a[j]和a[j-1]比较的
        for(j=1;j< (n-i);j++){
            if(a[j]<a[j-1]){
                swapEle(&a[j], &a[j-1]);
                flag = 1;
            }
        }
        if(flag == 0){
            break;
        }
    }
    printList(a, n);
}

/** 选择排序
 * 原理：
 */



