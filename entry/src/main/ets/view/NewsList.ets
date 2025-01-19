
import NewsItem from './NewsItem';
import LoadMoreLayout from './LoadMoreLayout';
import RefreshLayout from './RefreshLayout';
import { NewsData } from '../viewmodel/NewsData';
import Constants, { PageState } from '../common/constant/Constants';
import NewsViewModel from '../viewmodel/NewsViewModel';
import { showToast } from '../common/tools/Toast';
import FailureLayout from './FailureLayout';
import LoadingLayout from './LoadingLayout';
import NoMoreLayout from './NoMoreLayout';
import RefreshListViewModel from '../viewmodel/RefreshListViewModel';


//新闻列表
@Component
export default struct NewsList {
  index: number = 0;
  @Watch('changeCategory') @Link currentIndex: number;
  @State refreshStore: RefreshListViewModel = new RefreshListViewModel();

  changeCategory() {
    if (this.currentIndex !== this.index) {
      return;
    }
    this.refreshStore.currentPage = 1;
    NewsViewModel.getNewsList(this.refreshStore.currentPage, this.refreshStore.pageSize).then((data: NewsData[]) => {
      this.refreshStore.pageState = PageState.Success;
      if (data.length === this.refreshStore.pageSize) {
        this.refreshStore.currentPage++;
        this.refreshStore.hasMore = true;
      } else {
        this.refreshStore.hasMore = false;
      }
      this.refreshStore.newsData = data;
    }).catch((err: string | Resource) => {
      showToast(err);
      this.refreshStore.pageState = PageState.Fail;
    });
  }

  aboutToAppear() {
    // Load data.
    this.changeCategory();
  }

  reloadAction() {
    this.refreshStore.pageState = PageState.Loading;
    this.changeCategory();
  }

  build() {
    Column() {
      if (this.refreshStore.pageState === PageState.Loading) {
        LoadingLayout()
      } else if (this.refreshStore.pageState === PageState.Success) {
        this.ListLayout()
      } else {
        FailureLayout({ reloadAction: () => {
          this.reloadAction();
        } })
      }
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
    .onTouch((event?: TouchEvent) => {
      if (event) {
        if (this.refreshStore.pageState === PageState.Success) {
          this.refreshStore.listTouchEvent(event);
        }
      }
    })
  }

  @Builder ListLayout() {
    List({ space: Constants.LIST_SPACE }) {
      ListItem() {
        RefreshLayout({ refreshLoadingClass: this.refreshStore.refreshLayoutClass })
      }
      ForEach(this.refreshStore.newsData, (item: NewsData) => {
        ListItem() {
          NewsItem({ newsData: item })
        }
        .backgroundColor($r('app.color.white'))
        .borderRadius($r('app.float.item_border_radius'))
      }, (item: NewsData, index?: number) => JSON.stringify(item) + index)
      ListItem() {
        if (this.refreshStore.hasMore) {
          LoadMoreLayout({ loadMoreLayoutClass: this.refreshStore.loadingMoreClass })
        } else {
          NoMoreLayout()
        }
      }
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .padding({ left: $r('app.float.common_padding'), right: $r('app.float.common_padding') })
    .backgroundColor($r('app.color.listColor'))
    .edgeEffect(EdgeEffect.None)
    .onScrollIndex((start: number, end: number) => {

      this.refreshStore.startIndex = start;
      this.refreshStore.endIndex = end;
    })
  }
}