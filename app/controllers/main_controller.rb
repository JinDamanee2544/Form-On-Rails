class MainController < ApplicationController
  
  def select
    render 'select'
  end
  
  def test
    @amount = params[:amount].to_i
    @subjectValue = params[:subjectValue]
    @errorSubject = params[:errorSubject]
    @scoreValue = params[:scoreValue]
    @errorScore = params[:errorScore]
  end


  def validate
    @subjectList = []
    @errorSubject = []

    @scoreList = []
    @errorScore = []
    # loop checking subjects
    for i in 1..params[:amount].to_i do 
      if(params["subject#{i}"] != "")
        @subjectList.push(params["subject#{i}"])
      else
        @subjectList.push("")
        @errorSubject.push(i.to_i)
      end
    end
    # loop checking scores
    for i in 1..params[:amount].to_i do 
      if(params["score#{i}"] != "")
        @scoreList.push(params["score#{i}"])
      else
        @scoreList.push("")
        @errorScore.push(i.to_i)
      end
    end

    if(@errorSubject.length == 0 and @errorScore.length == 0)
      redirect_to action: 'display' ,subjectList: @subjectList, scoreList: @scoreList
    else
      redirect_to action: 'test', amount: params[:amount] , errorSubject: @errorSubject , subjectValue: @subjectList , errorScore: @errorScore , scoreValue: @scoreList
    end 
  end 

  def display
    @subjectList = params[:subjectList]
    @scoreList = params[:scoreList]

    @totalScore = 0
    @highestScore = @scoreList[0].to_i
    @scoreList.each do |score|
      if(score.to_i > @highestScore)
        @highestScore = score.to_i
      end
      @totalScore += score.to_i
    end
    
    @bestSubject = @subjectList[@scoreList.index(@highestScore.to_s)]
    @averageScore = @totalScore / @scoreList.length
  end

end
