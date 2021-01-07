//
//  OkashiSearchViewModel.swift
//  RxOkashi
//
//  Created by Newton on 2020/12/24.
//

import RxSwift
import RxCocoa

class OkashiSearchViewModel {
    
    let okashiPages: Observable<[OkashiPage]>
//    let error: Observable<Error>

    init(searchWord: Observable<String>, okashiAPI: OkashiAPI){
        
        okashiPages = searchWord
            .filter { 3 <= $0.count }
            .flatMapLatest { return okashiAPI.search(from: $0)
                .catchErrorJustReturn([])
            }
            .share(replay: 1)
        
//        let sequence = searchWord
//            .filter { 3 <= $0.count }
//            .flatMapLatest { return wikipediaAPI.search(from: $0)
//                .materialize()
//            }
//            .share(replay: 1)
        
//        wikipediaPages = sequence.elements()
//        error = sequence.erros()
            
    }
    
}

//class OkashiSearchViewModel {
//  private let disposeBag = DisposeBag()
//
//  private let okashiAPI: OkashiAPI
//  private let scheduler: SchedulerType
//
//  init(okashiAPI: OkashiAPI,
//       scheduler: SchedulerType = ConcurrentMainScheduler.instance) {
//    self.okashiAPI = okashiAPI
//    self.scheduler = scheduler
//  }
//}

//extension OkashiSearchViewModel: ViewModelType {
//
//    struct Input {
//        let searchText: Observable<String>
//    }
//
//    struct Output {
//        let okashiPages: Observable<[OkashiPage]>
//        let searchDescription: Observable<String>
//        let error: Observable<Error>
//    }
//
//    func transform(input: Input) -> Output {
//        let filterdText = input.searchText
//            .debounce(.milliseconds(300), scheduler: scheduler)
////          .debounce(0.3, scheduler: scheduler)
//          .share(replay: 1)
//
//        let sequence = filterdText
//          .flatMapLatest { [unowned self] text -> Observable<Event<[OkashiPage]>> in
//            return self.okashiAPI
//              .search(from: text)
//              .materialize()
//          }
//          .share(replay: 1)
//
//        let okashiPages = sequence.elements()
//
//        let _searchDescription = PublishRelay<String>()
//
//        okashiPages
//          .withLatestFrom(filterdText) { (pages, word) -> String in
//            return "\(word) \(pages.count)件"
//          }
//          .bind(to: _searchDescription)
//          .disposed(by: disposeBag)
//
//        return Output(OkashiPages: okashiPages,
//                      searchDescription: _searchDescription.asObservable(),
//                      error: sequence.errors())
//    }
//
//}
